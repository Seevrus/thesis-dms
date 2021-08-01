import React, { useEffect } from 'react';
import { Container } from 'react-bootstrap';
import { useSelector } from 'react-redux';
import { useHistory } from 'react-router';

import SingleDocument from './SingleDocument';

import { EMAIL_STATUS, userEmailStatus } from '../../store/usersSlice';

const Documents = () => {
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
      <h3 className="text-center">Dokumentumaim</h3>
      <SingleDocument />
      <SingleDocument />
      <SingleDocument />

      <div className="container letoltes_blokk mt-3">
        <div className="d-flex justify-content-end">
          Icons made by&nbsp;
          <a href="https://www.freepik.com" title="Freepik">Freepik</a>
&nbsp;from&nbsp;
          <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
        </div>
      </div>
    </Container>
  );
};

export default Documents;
