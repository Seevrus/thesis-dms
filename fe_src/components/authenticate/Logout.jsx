import React, { useEffect, useState } from 'react';
import { Container } from 'react-bootstrap';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router';

import { logout } from '../../store/usersSlice';

const Logout = () => {
  const dispatch = useDispatch();
  const history = useHistory();
  const [logoutMessage, setLogoutMessage] = useState('');

  useEffect(() => {
    dispatch(logout())
      .then(({ payload: { message } }) => {
        setLogoutMessage(message);
        history.push('/');
      });
  }, [dispatch, history]);

  return (
    <Container>
      {logoutMessage}
    </Container>
  );
};

export default Logout;
