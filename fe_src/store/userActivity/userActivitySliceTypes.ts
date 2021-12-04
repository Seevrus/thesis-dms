export enum UserActivityColumnsEnum {
  companyName = 'Cég',
  userRealName = 'Munkavállaló',
  categoryName = 'Kategória',
  documentName = 'Dokumentum',
  added = 'Hozzáadva',
  validUntil = 'Érvényes',
  downloaded = 'Letöltve',
}

export interface ActivityRequestT {
  companyName: string[];
  userRealName: string[];
  categoryName: string[];
  documentName: string[];
  added: {
    from?: string;
    to?: string;
  };
  validUntil: {
    checked: boolean;
    from?: string;
    to?: string;
  };
  downloaded: {
    checked: boolean;
    from?: string;
    to?: string;
  };
}

interface UAKeys {
  [key: string]: any;
}

export interface UserActivityT extends UAKeys {
  id: number;
  companyName: string;
  userRealName: string;
  categoryName: string;
  documentName: string;
  added: Date;
  validUntil: Date;
  downloadedAt: Date;
}
