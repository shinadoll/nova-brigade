export type Action = {
  shortName: string;
  displayName: string;
  userID: number;
};

export type PlayerState = {
  userID: number; // Session-persistent random number representing a specific user
  characterName: string;
  hp: number;
  actions: Action[]; // Listl of actions available to the user at the time of sending.
};

export type StateUpdate = {
  modifiedCharacterStates: PlayerState[]; // List of character states which have been changed, to be broken up by the server.
};
