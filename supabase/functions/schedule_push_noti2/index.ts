import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'
import serviceAccount from '../service-account.json' with { type: 'json' }

interface Notification {
  id: string
  user_id: string
  body: string
}

interface WebhookPayload {
  type: string
  table: string
  record: Notification
  old_record: Notification
  schema: 'public'
}

Deno.serve(async (req: Request) => {
  const payload: WebhookPayload = await req.json()

  console.log(payload);

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
  )

  const { data } = await supabase
    .from('profiles')
    .select('fcm_token')
    .eq('user_id', payload.record.user_id)
    .single()

  console.log(data)

  const fcmToken = data!.fcm_token as string

  // Parse the scheduled time and calculate delay
  const scheduledTime = new Date(payload.record.datetime).getTime(); // Converts to milliseconds
  const currentTime = Date.now(); // Current time in milliseconds
  const delay = scheduledTime - currentTime;

  console.log('Scheduled time:', new Date(scheduledTime).toISOString());
  console.log('Current time:', new Date(currentTime).toISOString());
  console.log('Delay (ms):', delay);

  if (delay > 0) {
    console.log(`Notification will be sent in ${(delay / 1000).toFixed(2)} seconds.`);
    setTimeout(async () => {
      try {
        await scheduleNotification(fcmToken, payload);
      } catch (err) {
        console.error('Failed to send notification:', err);
      }
    }, delay);
  } else {
    await scheduleNotification(fcmToken, payload);
    console.error('Scheduled time is in the past. Notification will not be sent.');
  }

  return new Response(JSON.stringify({ message: "Notification scheduled" }), {
    headers: { 'Content-Type': 'application/json' },
  })
})

const scheduleNotification = async (fcmToken: string, payload: WebhookPayload) => {
  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key,
  })

  const res = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${accessToken}`,
      },
      body: JSON.stringify({
        message: {
          token: fcmToken,
          notification: {
            title: `Notification from Supabase`,
            body: `${payload.type} - ${payload.record.title}`,
          },
        },
      }),
    }
  )

  const resData = await res.json()
  if (res.status < 200 || 299 < res.status) {
    throw resData
  }
}

const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return
      }
      resolve(tokens!.access_token!)
    })
  })
}