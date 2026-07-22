// Cliente de Supabase para el frontend.
// La "publishable key" es pública por diseño (protegida por Row Level Security), segura de exponer en el navegador.
const SUPABASE_URL = 'https://xqwnsvdwxxfwumlkfkcr.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_kEUaqSzt5gLyB6Og8VtwgA_q0XtuOOC';

const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);
