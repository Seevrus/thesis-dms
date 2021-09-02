import * as React from 'react';
import { Container } from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppSelector } from '../store/hooks';
import { EmailStatusEnum } from '../store/usersSliceTypes';
import { userEmailStatus } from '../store/usersSlice';

const { useEffect } = React;

const Profile = () => {
  const history = useHistory();

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  useEffect(() => {
    if (!emailStatus) {
      history.push('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus]);
  // End of redirections

  return (
    <Container className="mt-5 mb-5">
      <h3 className="page-title text-center">Profilom</h3>
    </Container>
  );
};

export default Profile;
