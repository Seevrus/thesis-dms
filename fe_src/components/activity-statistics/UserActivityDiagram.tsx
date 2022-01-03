/* eslint-disable quote-props */
import {
  all,
  complement,
  equals,
  findIndex,
  isNil,
  values,
} from 'ramda';
import { useEffect, useState } from 'react';
import { Card, Col, Row } from 'react-bootstrap';
import ChartistGraph from 'react-chartist';

import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { fetchLoginStatistics, selectLoginStatistics } from '../../store/statistics/statisticsSlice';
import { Mapper } from '../../interfaces/common';
import SimpleCompany from './SimpleCompany';
import SimpleUser from './SimpleUser';

import './user-activity-diagram.scss';

const ACTIVITY_LABELS: Mapper = {
  '1 hét': 'lastWeek',
  '2 hét': 'lastTwoWeeks',
  '1 hónap': 'lastMonth',
  '2 hónap': 'lastTwoMonths',
  '3 hónap': 'lastThreeMonths',
  '6 hónap': 'lastSixMonths',
  'több': 'moreThanSixMonths',
};

const UserActivityDiagram = () => {
  const dispatch = useAppDispatch();

  const loginStatistics = useAppSelector(selectLoginStatistics);
  const [companyName, setCompanyName] = useState<string>(undefined);
  const [series, setSeries] = useState(new Array(7).fill(0));

  const data = {
    labels: [
      '1 hét',
      '2 hét',
      '1 hónap',
      '2 hónap',
      '3 hónap',
      '6 hónap',
      'több',
    ],
    series,
  };

  useEffect(() => {
    dispatch(fetchLoginStatistics({ companyName }));
  }, [companyName, dispatch]);

  useEffect(() => {
    if (all(complement(isNil), values(loginStatistics))) {
      setSeries([
        loginStatistics[ACTIVITY_LABELS['1 hét']],
        loginStatistics[ACTIVITY_LABELS['2 hét']],
        loginStatistics[ACTIVITY_LABELS['1 hónap']],
        loginStatistics[ACTIVITY_LABELS['2 hónap']],
        loginStatistics[ACTIVITY_LABELS['3 hónap']],
        loginStatistics[ACTIVITY_LABELS['6 hónap']],
        loginStatistics[ACTIVITY_LABELS['több']],
      ]);
    }
  }, [loginStatistics]);

  const options = {
    distributeSeries: true,
    axisX: {
      labelInterpolationFnc(value: string) {
        return `${findIndex(equals(value), data.labels) + 1}.`;
      },
      showGrid: false,
    },
    axisY: {
      labelInterpolationFnc(value: number) {
        return `${(value * 100).toFixed(1)}%`;
      },
      offset: 60,
    },
    height: '245px',
  };

  const responsiveOptions = [
    [
      'screen and (min-width: 550px)',
      {
        axisX: {
          labelInterpolationFnc(value: string) {
            return value;
          },
        },
      },
    ],
  ];

  return (
    <Card>
      <Card.Header className="statistics-header">
        <Card.Title as="h4" className="statistics-title">
          Felhasználói aktivitás
        </Card.Title>
        <SimpleCompany setCompanyName={setCompanyName} />
      </Card.Header>
      <Card.Body>
        <Row>
          <Col lg="8">
            <ChartistGraph
              data={data}
              options={options}
              responsiveOptions={responsiveOptions}
              type="Bar"
              listener={{
                draw: (e) => e.type === 'bar' && e.element.attr({
                  style: 'stroke-width: 3vw',
                }),
              }}
            />
          </Col>
          <SimpleUser />
        </Row>
      </Card.Body>
    </Card>
  );
};

export default UserActivityDiagram;
