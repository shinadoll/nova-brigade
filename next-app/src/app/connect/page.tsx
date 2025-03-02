"use client";

import ActionButton from "@/app/ui/ActionButton/page.tsx";

export default function Page() {
  return (
    <div>
      <ActionButton actionNickname="Disentangle" actionCode="0" />
      <ActionButton actionNickname="Recombobulate" actionCode="1" />
      <ActionButton
        actionNickname="Transubstantiate"
        actionCode="2"
      />
      <ActionButton actionNickname="Gun" actionCode="3" />
    </div>
  );
}
