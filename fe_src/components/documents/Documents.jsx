import React, { useEffect, useState } from 'react';
import { Container, Spinner } from 'react-bootstrap';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router';

import SingleDocument from './SingleDocument';

import {
  EMAIL_STATUS,
  LOGIN_STATUS,
  userEmailStatus,
  userLoginStatus,
} from '../../store/usersSlice';
import { fetchDocuments } from '../../store/documentsSlice';

const Documents = () => {
  const dispatch = useDispatch();
  const history = useHistory();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  // Redirect user is they are not supposed to be here
  const emailStatus = useSelector(userEmailStatus);
  const loginStatus = useSelector(userLoginStatus);

  useEffect(() => {
    if (!loginStatus) {
      setIsComponentLoading(true);
    } else {
      setIsComponentLoading(false);
    }

    if (loginStatus === LOGIN_STATUS.NOT_LOGGED_IN) {
      history.push('/login');
    } else if (emailStatus === EMAIL_STATUS.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EMAIL_STATUS.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus, loginStatus]);
  // End of redirections

  useEffect(() => {
    if (emailStatus === EMAIL_STATUS.VALID_EMAIL) {
      dispatch(fetchDocuments());
    }
  }, [emailStatus]);

  return (
    <Container className="mt-5 mb-5">
      {isComponentLoading ? (
        <Container className="spinner-container">
          <Spinner animation="border" role="status" variant="secondary">
            <span className="visually-hidden">Loading...</span>
          </Spinner>
        </Container>
      )
        : (
          <>
            <h3 className="text-center">Dokumentumaim</h3>
            <SingleDocument />
            <SingleDocument />
            <SingleDocument />

            <Container className="letoltes_blokk mt-3">
              <div className="d-flex justify-content-end">
                Icons made by&nbsp;
                <a href="https://www.freepik.com" title="Freepik">Freepik</a>
&nbsp;from&nbsp;
                <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
              </div>
            </Container>
          </>
        )}
    </Container>
  );
};

export default Documents;
