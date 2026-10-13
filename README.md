# Lisa: setup (Hinglish)

## 1. Supabase (login + sync)
1. supabase.com par project banao.
2. SQL editor mein `supabase-setup.sql` poora run karo.
3. Authentication > Providers: Email on rakho. "Confirm email" on rakho (email verification ke liye).
4. Authentication > URL Configuration: Site URL mein apni website ka link daalo. Redirect URLs mein bhi wahi link (password reset ke liye zaroori).
5. Project Settings > API se `Project URL` aur `anon public` key copy karo.
6. `config.js` kholo aur dono values daalo. `service_role` key kabhi mat daalna.

## 2. Hosting (website + PWA)
- Is poore folder ko static hosting par daalo (Vercel, Netlify, Cloudflare Pages). HTTPS zaroori hai.
- Custom domain hosting dashboard se connect karo, phir Supabase URL Configuration mein naya link update karo.
- Chrome/Edge (desktop) mein address bar ka Install icon, Android mein "Add to Home screen", iPhone Safari mein Share > Add to Home Screen.
- Naya version daalo to `sw.js` mein `V="lisa-v3"` ko `lisa-v4` karo, taaki purana cache hat jaye.

## 3. APK with background alarms (Capacitor)
Is folder mein `package.json`, `capacitor.config.json` aur `prep.js` ready hain.
```
npm install
npx cap add android            # sirf pehli baar
npm run android                # web files copy karta hai, sync karta hai, Android Studio kholta hai
```
Android Studio mein `android/app/src/main/AndroidManifest.xml` kholo aur `<manifest>` ke andar ye permissions daalo:
```
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE"/>
```
Phir Build > Build APK.

Lisa app khulte hi alarms aur (agar Settings mein reminders on hain) timetable reminders Android ke notification system mein schedule kar deta hai. Isliye app band hone par bhi notification aata hai.

Kya yaad rakhna hai:
- Android 12+ par pehli baar "Alarms and reminders" ki permission screen khulti hai. Use allow karna zaroori hai, warna alarm der se aa sakta hai.
- Ye heads-up notification hai jisme ek baar sound bajta hai. Ye clock app jaisa baar-baar bajne wala alarm nahi hai. Wo banane ke liye alag native code (AlarmManager aur foreground service) chahiye.
- Kuch phones (Xiaomi, Oppo, Vivo, Samsung) battery saver mein notification rok dete hain. Lisa ko "Unrestricted battery" do.
- Ye maine asli phone par test nahi kiya. Sirf ek nakli (mock) plugin se schedule ka data check kiya hai.
- Web aur PWA mein band app par alarm nahi baj sakta. Uske liye server se push bhejna padega, jo abhi nahi bana.

## Timetable aur plan
- Monday se Saturday ka timetable ek hai, Sunday ka alag hai (6:30 AM wake up se 9:30 PM sleep). Sunday ko poori website Sunday ke timetable par chalti hai: tasks, meals ke time, study ke time, sleep card aur reminders.
- Workout plan PCODFIT ka hai (Mon se Sat). Sunday ke liye maine Sunday wale doc ka beginner home workout rakha hai, jo optional hai. PCODFIT doc mein Sunday "complete rest" likha hai. Dono mein takkar hai, to chaho to Fitness mein Sunday ka plan edit karke rest bana do.
