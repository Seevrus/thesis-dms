import * as React from 'react';
import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableUserHandling = loadable(() => import('./UserHandling'), {
  fallback: <Loading />,
});

export default LoadableUserHandling;
