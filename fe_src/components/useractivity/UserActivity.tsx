import * as React from 'react';
import {
  Container,
  Table,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { listUserActivity, selectActivities } from '../../store/userActivitySlice';
import { EmailStatusEnum } from '../../store/usersSliceTypes';
import { userEmailStatus } from '../../store/usersSlice';
import FilterList, { FilterType } from './FilterList';

const { useEffect, useState } = React;

const UserActivity = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  const [companyFilterVisibility, setCompanyFilterVisibility] = useState('none');

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

  useEffect(() => {
    if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      dispatch(listUserActivity({ }));
    }
  }, [emailStatus]);

  const companyFilters: FilterType = [
    {
      checked: true,
      id: 'balazs',
      label: 'Balázs és Tsa Bt.',
    },
    {
      checked: true,
      id: 'jonas',
      label: 'Jónás Nyrt.',
    },
  ];

  const activities = useAppSelector(selectActivities);

  return (
    <Container className="mt-5 mb-5" onClick={() => setCompanyFilterVisibility('none')}>
      <h3 className="page-title text-center">Felhasználói aktivitás</h3>
      <Table striped bordered hover responsive="md" size="sm">
        <thead>
          <tr>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              setCompanyFilterVisibility('block');
            }}
            >
              Cég
              <FilterList
                options={companyFilters}
                setVisibility={setCompanyFilterVisibility}
                style={{ display: companyFilterVisibility }}
              />
            </th>
            <th>Munkavállaló</th>
            <th>Kategória</th>
            <th>Dokumentum</th>
            <th>Hozzáadva</th>
            <th>Érvényes</th>
            <th>Letöltve</th>
          </tr>
        </thead>
        <tbody>
          {activities.map((activity) => (
            <tr key={activity.id}>
              <td>{activity.companyName}</td>
              <td>{activity.userRealName}</td>
              <td>{activity.categoryName}</td>
              <td>{activity.documentName}</td>
              <td>{activity.added}</td>
              <td>{activity.validUntil || 'Korlátlan'}</td>
              <td>{activity.downloadedAt || 'Még nem töltötte le'}</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </Container>
  );
};

export default UserActivity;
