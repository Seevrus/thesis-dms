import { differenceInCalendarDays } from 'date-fns';
import { map } from 'ramda';
import { useEffect, useState } from 'react';
import { Col, Row } from 'react-bootstrap';
import Select from 'react-select';
import makeAnimated from 'react-select/animated';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { UserSearchTypeEnum } from '../../store/otherUsers/otherUsersSliceTypes';
import { SimpleUserT } from '../../store/statistics/statisticsSliceTypes';
import {
  clearUser,
  searchSimpleUsers,
  selectSelectedUser,
  selectSimpleUsers,
  setUser,
} from '../../store/statistics/statisticsSlice';
import { OptionsT } from '../../interfaces/common';
import debounce from '../utils/debounce';

const SimpleUser = () => {
  const dispatch = useAppDispatch();
  const animatedComponents = makeAnimated();

  const users = useAppSelector(selectSimpleUsers);
  const selectedUser = useAppSelector(selectSelectedUser);
  const [userOptions, setUserOptions] = useState<OptionsT[]>();
  const [lastLoginTime, setLastLoginTime] = useState<Date>(null);

  useEffect(
    () => {
      dispatch(searchSimpleUsers({
        keyword: '',
        searchType: UserSearchTypeEnum.LAST_LOGIN,
      }));
    }, [dispatch],
  );

  useEffect(
    () => {
      setUserOptions(
        map((user: SimpleUserT): OptionsT => ({
          label: `${user.userRealName} (${user.companyName})`,
          value: String(user.taxNumber),
        }), users),
      );
    }, [users],
  );

  useEffect(
    () => {
      // eslint-disable-next-line @typescript-eslint/no-unused-expressions
      selectedUser
        ? setLastLoginTime(new Date(selectedUser.lastLogin))
        : setLastLoginTime(null);
    }, [selectedUser],
  );

  const handleChange = (user: OptionsT) => {
    if (user) {
      const userTaxNumber = Number(user.value);
      dispatch(setUser(userTaxNumber));
    } else {
      dispatch(clearUser());
    }
  };

  const handleInputChange = (keyword: string) => {
    dispatch(searchSimpleUsers({
      keyword,
      searchType: UserSearchTypeEnum.LAST_LOGIN,
    }));
  };

  return (
    <Col lg="4">
      <Row className="statistics-select-row">
        <Select
          className="statistics-select"
          closeMenuOnSelect
          components={animatedComponents}
          isClearable
          noOptionsMessage={() => 'Nincs több találat'}
          onChange={handleChange}
          onInputChange={debounce(handleInputChange, 500)}
          options={userOptions}
          placeholder="Egyedi felhasználó..."
        />
      </Row>
      {lastLoginTime && (
      <Row className="user-data-row">
        <p className="user-data">
          Utolsó belépés:
          {' '}
          {lastLoginTime.toISOString().split('T')[0]}
        </p>
        <p className="user-data">
          Eltelt idő:
          {' '}
          {differenceInCalendarDays(Date.now(), lastLoginTime)}
          {' '}
          nap
        </p>
      </Row>
      )}
    </Col>
  );
};

export default SimpleUser;
