-- Unified paginated Echo history for club_reviews + bar_reviews
-- Returns paged records ordered by created_at desc with total_count for pagination UI.

CREATE OR REPLACE FUNCTION public.get_user_review_history_paginated(
  p_user_id uuid,
  p_page integer DEFAULT 1,
  p_limit integer DEFAULT 10
)
RETURNS TABLE (
  review_id text,
  venue_id text,
  venue_name text,
  venue_type text,
  music_rating integer,
  vibe_rating integer,
  crowd_rating integer,
  safety_rating integer,
  review_text text,
  queue_time integer,
  created_at timestamptz,
  total_count bigint
)
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
  v_page integer := GREATEST(COALESCE(p_page, 1), 1);
  v_limit integer := GREATEST(COALESCE(p_limit, 10), 1);
  v_offset integer := (v_page - 1) * v_limit;
BEGIN
  RETURN QUERY
  WITH merged AS (
    SELECT
      ('club_' || cr.id::text) AS review_id,
      cr.club_id::text AS venue_id,
      COALESCE(c.name, 'Unknown Club') AS venue_name,
      'club'::text AS venue_type,
      ROUND(COALESCE(cr.music_rating, 0) * 20)::integer AS music_rating,
      ROUND(COALESCE(cr.vibe_rating, 0) * 20)::integer AS vibe_rating,
      ROUND(COALESCE(cr.crowd_rating, 0) * 20)::integer AS crowd_rating,
      ROUND(COALESCE(cr.safety_rating, 0) * 20)::integer AS safety_rating,
      COALESCE(cr.review_text, '') AS review_text,
      cr.queue_time,
      cr.created_at
    FROM public.club_reviews cr
    LEFT JOIN public.clubs c ON c.id = cr.club_id
    WHERE cr.user_id = p_user_id

    UNION ALL

    SELECT
      ('bar_' || br.id::text) AS review_id,
      br.bar_id::text AS venue_id,
      COALESCE(b.name, 'Unknown Bar') AS venue_name,
      'bar'::text AS venue_type,
      ROUND(COALESCE(br.quality_rating, 0))::integer AS music_rating,
      ROUND(COALESCE(br.vibe_rating, 0))::integer AS vibe_rating,
      ROUND(COALESCE(br.price_rating, 0))::integer AS crowd_rating,
      ROUND(COALESCE(br.friendliness_rating, 0))::integer AS safety_rating,
      COALESCE(br.review_text, '') AS review_text,
      br.queue_time,
      br.created_at
    FROM public.bar_reviews br
    LEFT JOIN public.bars b ON b.id = br.bar_id
    WHERE br.user_id = p_user_id
  ),
  counted AS (
    SELECT
      m.*,
      COUNT(*) OVER () AS total_count
    FROM merged m
  )
  SELECT
    ctd.review_id,
    ctd.venue_id,
    ctd.venue_name,
    ctd.venue_type,
    ctd.music_rating,
    ctd.vibe_rating,
    ctd.crowd_rating,
    ctd.safety_rating,
    ctd.review_text,
    ctd.queue_time,
    ctd.created_at,
    ctd.total_count
  FROM counted ctd
  ORDER BY ctd.created_at DESC
  OFFSET v_offset
  LIMIT v_limit;
END;
$$;
