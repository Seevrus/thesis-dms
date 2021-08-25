import * as React from 'react';
import { Container } from 'react-bootstrap';
import { useHistory } from 'react-router';
import { useAppDispatch } from '../../store/hooks';

import { logout } from '../../store/usersSlice';

const { useEffect } = React;

const Logout = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  useEffect(() => {
    dispatch(logout())
      .then(() => history.push('/'));
  }, [dispatch, history]);

  return (
    <Container>
      Successful logout.
    </Container>
  );
};

export default Logout;
