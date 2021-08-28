import * as React from 'react';
import { Container } from 'react-bootstrap';
import { useHistory } from 'react-router';

import SingleDocument from './SingleDocument';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/usersSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/usersSlice';
import { fetchDocuments, selectDocumentIds } from '../../store/documentsSlice';
import Loading from '../utils/Loading';

const { useEffect, useState } = React;

const Documents = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  useEffect(() => {
    document.title = 'Dokumentumaim';
  }, []);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  const loginStatus = useAppSelector(userLoginStatus);

  useEffect(() => {
    if (!loginStatus) {
      setIsComponentLoading(true);
    } else {
      setIsComponentLoading(false);
    }

    if (loginStatus === LoginStatusEnum.NOT_LOGGED_IN) {
      history.push('/login');
    } else if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      history.push('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      history.push('/validate-email');
    }
  }, [emailStatus, loginStatus]);
  // End of redirections

  useEffect(() => {
    if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      dispatch(fetchDocuments({ }));
    }
  }, [emailStatus]);

  const documentIds = useAppSelector(selectDocumentIds) as number[];
  const documents = documentIds.map((id) => <SingleDocument key={id} id={id} />);

  return (
    <Container className="mt-5 mb-5">
      {isComponentLoading ? <Loading />
        : (
          <>
            <h3 className="text-center">Dokumentumaim</h3>
            {documents}

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
