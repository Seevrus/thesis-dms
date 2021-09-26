import {
  __,
  isEmpty,
  pipe,
  prop,
// @ts-ignore
} from 'ramda';
import * as React from 'react';
import {
  Container,
  Table,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import debounce from '../utils/debounce';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { UserActivityRequestT } from '../../store/userActivitySliceTypes';
import { listUserActivity, selectActivities } from '../../store/userActivitySlice';
import { EmailStatusEnum } from '../../store/usersSliceTypes';
import { userEmailStatus } from '../../store/usersSlice';

import DateFilter from './DateFilter';
import FilterList from './FilterList';

const { useEffect, useState } = React;

const UserActivity = () => {
  const dispatch = useAppDispatch();
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

  // state of all search keys coming from filters
  const [activityRequest, setActivityRequest] = useState<UserActivityRequestT>({
    companyName: [],
    userRealName: [],
    categoryName: [],
    documentName: [],
    added: {},
    validUntil: {},
    downloaded: {},
  });

  const canHideFilter: (column: string) => boolean = pipe(prop(__, activityRequest), isEmpty);

  useEffect(() => {
    if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      debounce(dispatch(listUserActivity(activityRequest)));
    }
  }, [activityRequest, emailStatus]);

  // filter visibilities
  const [companyFilterVisibility, setCompanyFilterVisibility] = useState('none');
  const [userFilterVisibility, setUserFilterVisibility] = useState('none');
  const [categoryFilterVisibility, setCategoryFilterVisibility] = useState('none');
  const [documentFilterVisibility, setDocumentFilterVisibility] = useState('none');
  const [addedVisibility, setAddedVisibility] = useState('none');

  const activities = useAppSelector(selectActivities);

  // Limit 50
  // endless scrolling (nice to have, majd ha még később lesz rá időnk)

  return (
    <Container className="mt-5 mb-5">
      <h3 className="page-title text-center">Felhasználói aktivitás</h3>
      <FilterList
        canHide={canHideFilter('companyName')}
        columnName="companyName"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setCompanyFilterVisibility}
        style={{ display: companyFilterVisibility }}
      />
      <FilterList
        canHide={canHideFilter('userRealName')}
        columnName="userRealName"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setUserFilterVisibility}
        style={{ display: userFilterVisibility }}
      />
      <FilterList
        canHide={canHideFilter('categoryName')}
        columnName="categoryName"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setCategoryFilterVisibility}
        style={{ display: categoryFilterVisibility }}
      />
      <FilterList
        canHide={canHideFilter('documentName')}
        columnName="documentName"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setDocumentFilterVisibility}
        style={{ display: documentFilterVisibility }}
      />
      <DateFilter
        canHide={canHideFilter('documentName')}
        columnName="added"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setAddedVisibility}
        style={{ display: addedVisibility }}
      />
      <Table striped bordered hover responsive="md" size="sm">
        <thead>
          <tr>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              companyFilterVisibility === 'none'
                ? setCompanyFilterVisibility('flex')
                : canHideFilter('companyName') && setCompanyFilterVisibility('none');
            }}
            >
              Cég
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              companyFilterVisibility === 'none'
                ? setUserFilterVisibility('flex')
                : canHideFilter('userRealName') && setUserFilterVisibility('none');
            }}
            >
              Munkavállaló
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              companyFilterVisibility === 'none'
                ? setCategoryFilterVisibility('flex')
                : canHideFilter('categoryName') && setCategoryFilterVisibility('none');
            }}
            >
              Kategória
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              companyFilterVisibility === 'none'
                ? setDocumentFilterVisibility('flex')
                : canHideFilter('documentName') && setDocumentFilterVisibility('none');
            }}
            >
              Dokumentum
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              addedVisibility === 'none'
                ? setAddedVisibility('flex')
                : canHideFilter('added') && setAddedVisibility('none');
            }}
            >
              Hozzáadva
            </th>
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
