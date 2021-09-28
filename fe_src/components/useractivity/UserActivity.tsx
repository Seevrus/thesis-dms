import {
  __,
  equals,
  isEmpty,
  omit,
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
import SaveLayout from './SaveLayout';

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
  const emptyActivityRequest: UserActivityRequestT = {
    companyName: [],
    userRealName: [],
    categoryName: [],
    documentName: [],
    added: {},
    validUntil: {
      checked: true,
    },
    downloaded: {
      checked: false,
    },
  };
  const [activityRequest, setActivityRequest] = useState<UserActivityRequestT>(
    emptyActivityRequest,
  );

  const canHideFilter: (column: string) => boolean = pipe(
    prop(__, activityRequest),
    omit(['checked']),
    isEmpty,
  );

  const showSaveLayout = !equals(emptyActivityRequest, activityRequest);

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
  const [addedFilterVisibility, setAddedFilterVisibility] = useState('none');
  const [validUntilFilterVisibility, setValidUntilFilterVisibility] = useState('none');
  const [downloadedFilterVisibility, setDownloadedFilterVisibility] = useState('none');

  const activities = useAppSelector(selectActivities);

  // endless scrolling (nice to have, majd ha még később lesz rá időnk)

  return (
    <Container className="mt-5 mb-5">
      <h3 className="page-title text-center">Felhasználói aktivitás</h3>
      {showSaveLayout && <SaveLayout />}
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
        canHide={canHideFilter('added')}
        columnName="added"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setAddedFilterVisibility}
        style={{ display: addedFilterVisibility }}
      />
      <DateFilter
        canHide={canHideFilter('validUntil')}
        columnName="validUntil"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setValidUntilFilterVisibility}
        style={{ display: validUntilFilterVisibility }}
      />
      <DateFilter
        canHide={canHideFilter('downloaded')}
        columnName="downloaded"
        filterState={activityRequest}
        setFilterState={setActivityRequest}
        setVisibility={setDownloadedFilterVisibility}
        style={{ display: downloadedFilterVisibility }}
      />
      <Table striped bordered hover responsive="md" size="sm">
        <thead>
          <tr>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              companyFilterVisibility === 'none'
                ? setCompanyFilterVisibility('block')
                : canHideFilter('companyName') && setCompanyFilterVisibility('none');
            }}
            >
              Cég
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              userFilterVisibility === 'none'
                ? setUserFilterVisibility('block')
                : canHideFilter('userRealName') && setUserFilterVisibility('none');
            }}
            >
              Munkavállaló
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              categoryFilterVisibility === 'none'
                ? setCategoryFilterVisibility('block')
                : canHideFilter('categoryName') && setCategoryFilterVisibility('none');
            }}
            >
              Kategória
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              documentFilterVisibility === 'none'
                ? setDocumentFilterVisibility('block')
                : canHideFilter('documentName') && setDocumentFilterVisibility('none');
            }}
            >
              Dokumentum
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              addedFilterVisibility === 'none'
                ? setAddedFilterVisibility('block')
                : canHideFilter('added') && setAddedFilterVisibility('none');
            }}
            >
              Hozzáadva
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              validUntilFilterVisibility === 'none'
                ? setValidUntilFilterVisibility('block')
                : canHideFilter('validUntil') && setValidUntilFilterVisibility('none');
            }}
            >
              Érvényes
            </th>
            <th onClick={(e: React.MouseEvent) => {
              e.stopPropagation();
              if (!(e.target instanceof HTMLTableCellElement)) return;
              // eslint-disable-next-line @typescript-eslint/no-unused-expressions
              downloadedFilterVisibility === 'none'
                ? setDownloadedFilterVisibility('block')
                : canHideFilter('downloaded') && setDownloadedFilterVisibility('none');
            }}
            >
              Letöltve
            </th>
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
