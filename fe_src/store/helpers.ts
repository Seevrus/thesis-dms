import { AxiosResponse } from 'axios';
import {
  filter,
  head,
  mapAccum,
  pipe,
  propEq,
} from 'ramda';

// TODO: I do not really handle partial errors other than displaying them
// eslint-disable-next-line import/prefer-default-export
export const checkUpdateProfileResponseForErrors = (response: AxiosResponse) => head(
  pipe(
    filter(propEq('outcome', 'failure')),
    mapAccum(
      (message: string, singleResponse: any) => [
        message
          ? `${message}. ${singleResponse.value}: ${singleResponse.message}`
          : `${singleResponse.value}: ${singleResponse.message}`,
        singleResponse.message,
      ],
      '',
    ),
  )(response.data),
);
