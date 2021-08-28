import * as React from 'react';
import loadable from '@loadable/component';
import Loading from '../utils/Loading';

const LoadableDocuments = loadable(() => import('./Documents'), {
  fallback: <Loading />,
});

export default LoadableDocuments;
