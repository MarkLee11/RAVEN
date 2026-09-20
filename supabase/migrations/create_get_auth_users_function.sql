-- Create RPC function to get auth users for reviews generation
CREATE OR REPLACE FUNCTION get_auth_users_for_reviews()
RETURNS TABLE (
  id UUID,
  email TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    au.id,
    au.email::TEXT
  FROM auth.users au
  WHERE au.email IS NOT NULL
  LIMIT 100;
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION get_auth_users_for_reviews() TO authenticated;
GRANT EXECUTE ON FUNCTION get_auth_users_for_reviews() TO anon;