import * as React from 'react';
import {
  Container,
  Table,
} from 'react-bootstrap';
import { useHistory } from 'react-router';

import debounce from '../utils/debounce';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import {
  fetchFilters,
  isAddedModified,
  isCategoryNameModified,
  isCompanyNameModified,
  isDocumentNameModified,
  isDownloadedModified,
  isFilterModified,
  isUserRealNameModified,
  isValidUntilModified,
  selectActiveFilter,
} from '../../store/activityFilterSlice';
import { listUserActivity, selectActivities } from '../../store/userActivitySlice';
import { EmailStatusEnum, LoginStatusEnum } from '../../store/userSliceTypes';
import { userEmailStatus, userLoginStatus } from '../../store/userSlice';
import Loading from '../utils/Loading';

import BrowseFilters from './BrowseFilters';
import DateFilter from './DateFilter';
import FilterList from './FilterList';
import SaveLayout from './SaveLayout';

const { useEffect, useState } = React;

const UserActivity = () => {
  const dispatch = useAppDispatch();
  const history = useHistory();

  const [isComponentLoading, setIsComponentLoading] = useState(true);

  // Redirect user is they are not supposed to be here
  const emailStatus = useAppSelector(userEmailStatus);
  const loginStatus = useAppSelector(userLoginStatus);
  useEffect(() => {
    if (!emailStatus) {
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

  // store integration
  const activeFilter = useAppSelector(selectActiveFilter);
  const canHideAdded = !useAppSelector(isAddedModified);
  const canHideCategoryName = !useAppSelector(isCategoryNameModified);
  const canHideCompanyName = !useAppSelector(isCompanyNameModified);
  const canHideDocumentName = !useAppSelector(isDocumentNameModified);
  const canHideDownloaded = !useAppSelector(isDownloadedModified);
  const canHideUserRealName = !useAppSelector(isUserRealNameModified);
  const canHideValidUntil = !useAppSelector(isValidUntilModified);
  const showSaveLayout = useAppSelector(isFilterModified);

  useEffect(() => {
    if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      debounce(dispatch(listUserActivity(activeFilter)));
    }
  }, [activeFilter, emailStatus]);

  useEffect(() => {
    if (emailStatus === EmailStatusEnum.VALID_EMAIL) {
      dispatch(fetchFilters());
    }
  }, []);
  // end of store integration

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

  if (isComponentLoading) {
    return (
      <Container className="mt-5 mb-5">
        <Loading />
      </Container>
    );
  }

  return (
    <Container className="mt-5 mb-5">
      <h3 className="page-title text-center">Felhasználói aktivitás</h3>
      <BrowseFilters />
      {showSaveLayout && <SaveLayout />}
      <FilterList
        canHide={canHideCompanyName}
        columnName="companyName"
        setVisibility={setCompanyFilterVisibility}
        style={{ display: companyFilterVisibility }}
      />
      <FilterList
        canHide={canHideUserRealName}
        columnName="userRealName"
        setVisibility={setUserFilterVisibility}
        style={{ display: userFilterVisibility }}
      />
      <FilterList
        canHide={canHideCategoryName}
        columnName="categoryName"
        setVisibility={setCategoryFilterVisibility}
        style={{ display: categoryFilterVisibility }}
      />
      <FilterList
        canHide={canHideDocumentName}
        columnName="documentName"
        setVisibility={setDocumentFilterVisibility}
        style={{ display: documentFilterVisibility }}
      />
      <DateFilter
        canHide={canHideAdded}
        columnName="added"
        setVisibility={setAddedFilterVisibility}
        style={{ display: addedFilterVisibility }}
      />
      <DateFilter
        canHide={canHideValidUntil}
        columnName="validUntil"
        setVisibility={setValidUntilFilterVisibility}
        style={{ display: validUntilFilterVisibility }}
      />
      <DateFilter
        canHide={canHideDownloaded}
        columnName="downloaded"
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
                : canHideCompanyName && setCompanyFilterVisibility('none');
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
                : canHideUserRealName && setUserFilterVisibility('none');
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
                : canHideCategoryName && setCategoryFilterVisibility('none');
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
                : canHideDocumentName && setDocumentFilterVisibility('none');
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
                : canHideAdded && setAddedFilterVisibility('none');
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
                : canHideValidUntil && setValidUntilFilterVisibility('none');
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
                : canHideDownloaded && setDownloadedFilterVisibility('none');
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
