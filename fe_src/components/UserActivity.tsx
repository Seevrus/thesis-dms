import * as React from 'react';
import { Container, Table } from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppSelector } from '../store/hooks';
import { EmailStatusEnum } from '../store/usersSliceTypes';
import { userEmailStatus } from '../store/usersSlice';

const { useEffect } = React;

const UserActivity = () => {
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
      <h3 className="page-title text-center">Felhasználói aktivitás</h3>
      <Table striped bordered hover responsive="md" size="sm">
        <thead>
          <tr>
            <th>Cég</th>
            <th>Munkavállaló</th>
            <th>Dokumentum</th>
            <th>Letöltve</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Balázs és Tsa Bt.</td>
            <td>Senki Alfonz</td>
            <td>Bérjegyzék 2021. augusztus</td>
            <td>Még nem töltötte le</td>
          </tr>
          <tr>
            <td>Jónás Nyrt.</td>
            <td>Senkiné Mindenki Teréz</td>
            <td>Bérjegyzék 2021. december</td>
            <td>2021-12-13 6:31</td>
          </tr>
          <tr>
            <td>Jónás Nyrt.</td>
            <td>Besenyőné Bényei Margit</td>
            <td>Bérjegyzék 2021. augusztus</td>
            <td>2021-09-02 12:45</td>
          </tr>
        </tbody>
      </Table>
    </Container>
  );
};

export default UserActivity;
