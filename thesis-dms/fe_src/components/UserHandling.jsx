import React, { useEffect } from 'react';
import { Container } from 'react-bootstrap';
import { useSelector } from 'react-redux';
import { useHistory } from 'react-router';

import { EMAIL_STATUS, userEmailStatus } from '../store/usersSlice';

const UserHandling = () => {
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useSelector(userEmailStatus);
  useEffect(() => {
    if (!emailStatus) {
      history.push('/login');
    } else if (emailStatus === EMAIL_STATUS.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EMAIL_STATUS.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus]);
  // End of redirections

  return (
    <Container className="mt-5 mb-5">
      <h3 className="text-center">Felhasználók kezelése</h3>
    </Container>
  );
};

export default UserHandling;
