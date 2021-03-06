import { useEffect, useState } from 'react';
import { Container } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { EmailStatusEnum } from '../../store/user/userSliceTypes';
import { userEmailStatus } from '../../store/user/userSlice';
import { fetchDocuments, selectDocumentIds } from '../../store/documents/documentsSlice';

import Loading from '../utils/Loading';
import SingleDocument from './SingleDocument';

const Documents = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  useEffect(() => {
    document.title = 'Dokumentumaim';
  }, []);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);

  useEffect(() => {
    if (!emailStatus) {
      setIsComponentLoading(true);
    } else {
      setIsComponentLoading(false);
    }

    if (emailStatus === EmailStatusEnum.NO_EMAIL) {
      navigate('/complete-registration');
    } else if (emailStatus === EmailStatusEnum.NOT_VALIDATED) {
      navigate('/validate-email');
    }
  }, [emailStatus, navigate]);
  // End of redirections

  const documentIds = useAppSelector(selectDocumentIds) as number[];

  useEffect(() => {
    if (emailStatus === EmailStatusEnum.VALID_EMAIL && !documentIds.length) {
      dispatch(fetchDocuments({ }));
    }
  }, [dispatch, documentIds, emailStatus]);

  const documents = documentIds.map((id) => <SingleDocument key={id} id={id} />);

  if (isComponentLoading) {
    return <Loading />;
  }

  return (
    <Container className="mt-5 mb-5">
      {documents}

      <Container className="letoltes_blokk mt-3">
        <div className="d-flex justify-content-end">
          Icons made by&nbsp;
          <a href="https://www.freepik.com" title="Freepik">Freepik</a>
&nbsp;from&nbsp;
          <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
        </div>
      </Container>
    </Container>
  );
};

export default Documents;
