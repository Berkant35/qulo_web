abstract final class Env {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://vtntrtozgoyhjdvvurkj.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0bnRydG96Z295aGpkdnZ1cmtqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI4ODg1MTMsImV4cCI6MjA4ODQ2NDUxM30.bDonZohUQUynDYd8rttQyGTi-o2Pktd5a9Zv5LeHxCA',
  );
}
