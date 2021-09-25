export enum UserActivityColumnsEnum {
  companyName = 'Cég',
  userRealName = 'Munkavállaló',
  categoryName = 'Kategória',
  documentName = 'Dokumentum',
  added = 'Hozzáadva',
  validUntil = 'Érvényes',
  downloaded = 'Letöltve',
}

export interface UserActivityRequestT {
  companyName: string[];
  userRealName: string[];
  categoryName: string[];
  documentName: string[];
  added?: string;
  validUntil?: string;
  downloaded?: string;
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
