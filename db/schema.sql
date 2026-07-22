-- Esquema inicial: banco de preguntas de teoría
-- Ejecutar en Supabase: Dashboard -> SQL Editor -> pegar y RUN

create table if not exists topics (
  id smallint primary key,
  title text not null
);

create table if not exists questions (
  id bigint generated always as identity primary key,
  topic_id smallint not null references topics(id),
  question_text text not null,
  option_a text not null,
  option_b text not null,
  option_c text not null,
  correct_option char(1) not null check (correct_option in ('a','b','c')),
  explanation text,
  created_at timestamptz not null default now()
);

create index if not exists questions_topic_id_idx on questions(topic_id);

-- Lectura pública (la web solo necesita leer preguntas, nunca escribirlas desde el navegador)
alter table topics enable row level security;
alter table questions enable row level security;

create policy "topics_public_read" on topics
  for select using (true);

create policy "questions_public_read" on questions
  for select using (true);

-- Los 40 temas oficiales del Anexo I (BOAM núm. 9.829, 28 feb 2025)
insert into topics (id, title) values
(1,  'La Constitución Española de 1978 (I): Estructura y contenido. Principios constitucionales básicos. Reforma de la Constitución.'),
(2,  'La Constitución Española de 1978 (II): Derechos y deberes fundamentales, defensa y garantía. Recurso de amparo. Defensor del Pueblo. Suspensión de derechos y libertades.'),
(3,  'La Constitución Española de 1978 (III): La Corona. Cortes Generales. Gobierno y Administración. Organización territorial. Comunidades Autónomas. Provincia. Municipio.'),
(4,  'Concepto de Derecho. La Administración y el Derecho. Principio de legalidad. Derecho Administrativo. El Reglamento: concepto, clases y potestad reglamentaria.'),
(5,  'La Comunidad de Madrid: origen y características. Estatuto de Autonomía de Madrid. Instituciones de Gobierno.'),
(6,  'La Administración Local: concepto, entidades, el municipio, organización municipal, órganos y competencias.'),
(7,  'Reglamento Orgánico del Gobierno y de la Administración del Ayuntamiento de Madrid (2004): Áreas de Gobierno, Área de Vicealcaldía/Portavoz/Seguridad y Emergencias, Juntas Municipales de Distrito.'),
(8,  'Reglamento para el Cuerpo de Policía Municipal (1995): Título III Funcionamiento del Cuerpo, Cap. I Disposiciones Generales y Cap. III el saludo.'),
(9,  'Ley Orgánica 4/2010, régimen disciplinario del CNP: Disposiciones Generales, Infracciones y Sanciones, Procedimientos Disciplinarios.'),
(10, 'Ley 1/2018, Coordinación de las Policías Locales de la CAM: Disposiciones Generales y Principios Básicos de Actuación.'),
(11, 'Reglamento Marco de Organización de las Policías Locales de la CAM (I): Marco Básico, Estructura y Organización, Promoción Interna y Movilidad.'),
(12, 'Reglamento Marco de Organización de las Policías Locales de la CAM (II): Formación, Régimen Disciplinario, Uniformidad/Equipo/Armamento.'),
(13, 'Ordenanza del Taxi (2012): Objeto y Ámbito, Conductores de Autotaxi, Condiciones de prestación del Servicio.'),
(14, 'Ordenanza de Protección del Medio Ambiente Urbano (1985): Protección de zonas verdes, uso y régimen disciplinario.'),
(15, 'Ordenanza de Limpieza de los Espacios Públicos y Residuos (2022) + Ordenanza de Salubridad Pública (2014).'),
(16, 'Ordenanza de Movilidad Sostenible (2018): Circulación y Aparcamiento, Ordenación y Señalización, Disciplina Viaria.'),
(17, 'Ordenanza de Protección contra la Contaminación Acústica y Térmica (2011).'),
(18, 'Ordenanza Municipal Reguladora de la Venta Ambulante (2003).'),
(19, 'Establecimientos, espectáculos y actividades recreativas: Ley 17/1997 y Decreto 184/1998 de la CAM.'),
(20, 'Estructura, organización y funcionamiento de los Tribunales. Jurisdicción y competencia penal. Procedimientos penales.'),
(21, 'Código Penal (I): Garantías penales, infracción penal, personas criminalmente responsables.'),
(22, 'Código Penal (II): De las Penas, Medidas de Seguridad, Extinción de la Responsabilidad Criminal.'),
(23, 'Código Penal (III): Homicidio, Lesiones, Delitos contra la libertad, Torturas, Trata de Seres Humanos.'),
(24, 'Código Penal (IV): Delitos contra la Libertad Sexual, contra el Patrimonio y Orden Socioeconómico.'),
(25, 'Código Penal (V): Delitos contra la Seguridad Colectiva - Salud Pública.'),
(26, 'Código Penal (VI): Delitos contra la Seguridad Colectiva - Seguridad Vial.'),
(27, 'Código Penal (VII): Delitos contra la Administración Pública y contra la Constitución.'),
(28, 'Normas y leyes de circulación en España. Organismos oficiales. Requisitos reglamentarios.'),
(29, 'Señalización. Normas generales, tipos y clases. Control automático del tráfico.'),
(30, 'Denuncias por infracciones de circulación. Procedimiento sancionador. Vehículos abandonados/inmovilizados.'),
(31, 'Concepto de accidente de tráfico. Unidades de tráfico. Clases de accidentes. Actuaciones.'),
(32, 'Alcoholemia: concepto, tasas, pruebas, alcoholímetros y etilómetros. Pruebas de detección de drogas.'),
(33, 'El modelo policial español. Fuerzas y Cuerpos de Seguridad. Policías Locales. Juntas Locales de Seguridad.'),
(34, 'Ley Orgánica 4/2015, Protección de la Seguridad Ciudadana.'),
(35, 'Ley Orgánica 4/2000, derechos y libertades de los extranjeros en España.'),
(36, 'Ley 5/2002, drogodependencias y otros trastornos adictivos.'),
(37, 'Ley Orgánica 1/2004, Violencia de Género + Ley 27/2003, Orden de protección.'),
(38, 'Ley Orgánica 3/2007, igualdad efectiva de mujeres y hombres.'),
(39, 'Ley 4/2023, igualdad efectiva de personas trans y garantía de derechos LGTBI.'),
(40, 'Ley 31/1995, prevención de Riesgos Laborales.')
on conflict (id) do nothing;
