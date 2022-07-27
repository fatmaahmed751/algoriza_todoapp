abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppDatabaseCreated extends AppStates{}

class AppDatabaseOpened extends AppStates{}

class AppDatabaseTableCreated extends AppStates{}

class AppDatabaseInserted extends AppStates{}

class AppGetDatabase extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppUpdateFavorite extends AppStates{}