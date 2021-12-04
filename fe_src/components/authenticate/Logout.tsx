import { useEffect } from 'react';
import { Container } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import { useAppDispatch } from '../../store/hooks';

import { logout } from '../../store/user/userSlice';

const Logout = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  useEffect(() => {
    dispatch(logout())
      .then(() => navigate('/'));
  }, [dispatch, navigate]);

  return (
    <Container>
      Successful logout.
    </Container>
  );
};

export default Logout;
