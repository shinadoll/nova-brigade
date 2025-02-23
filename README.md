# triangleGJ25

## Project Architecture

The _Godot Shared View_ (GSV) is the Godot program containing the shared view and the canonical game state.
The _Next.JS Server_ (Server) is the middleman connecting the GSV and MUI, the latter of which it serves.
The _Mobile UI_ (MUI) is the primary controller and a mobile-first webpage in Next.JS. Each MUI corresponds to a single player, contains control elements, and displays character info (e.g. HP).

### Relationships

The GSV and MUI never talk to each other; they always use the Server as the middleman.
When a user takes an action, they POST an Action object to the Server. The Server will then POST the same Action to the GSV. (As of now, the GSV polls the Server for recent actions).
When something occurs to one or more characters in the GSV-stored canonical game state, the GSV will POST a StateUpdate to the Server. The Server then POSTs a PlayerState to affected MUIs.

Godot Shared View <-(POST Action)- Server <-(POST Action)- Mobile UI
Godot Shared View -(POST StateUpdate)-> Server -(POST CharacterUpdate)-> Mobile UI

Instead of adding additional endpoints, little-used behavior is routed through the existing endpoints. - When a new player tries to join the game, their MUI will send an action with shortName and displayName "join" and userID 0. - When a player leaves, their MUI sends an action with shortName and displayName "leave" and their userID.

### Network Data Structures

```
Action:
shortName       string
displayName     string
userID          number

PlayerState:
userID          number
characterName   string
hp              number
actions         Action[]

StateUpdate:
modifiedCharacterStates CharacterState[]
```
