"use client";

import ActionButton from "@/app/ui/ActionButton/page.tsx";
import { Action } from "@/types/types.ts";

export default function Page() {
  let disentangle: Action = {
    shortName: "disentangle",
    displayName: "Disentangle",
    userID: 0,
  };

  let transubstantiate: Action = {
    shortName: "transubstantiate",
    displayName: "Transubstantiate",
    userID: 0,
  };

  let gun: Action = {
    shortName: "gun",
    displayName: "Gun",
    userID: 0,
  };

  let recombobulate: Action = {
    shortName: "recombobulate",
    displayName: "Recombobulate",
    userID: 0,
  };

  return (
    <div>
      <ActionButton action={disentangle} />
      <ActionButton action={recombobulate} />
      <ActionButton action={transubstantiate} />
      <ActionButton action={gun} />
    </div>
  );
}
