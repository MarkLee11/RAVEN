-- Echo history query acceleration indexes
-- Safe to re-run due to IF NOT EXISTS guards.

CREATE INDEX IF NOT EXISTS idx_club_reviews_user_created_at
ON public.club_reviews (user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_bar_reviews_user_created_at
ON public.bar_reviews (user_id, created_at DESC);
