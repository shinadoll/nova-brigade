"use client";

import ActionButton from "@/app/ui/ActionButton/page.tsx";

export default function Page() {
  return (
    <div>
      <ActionButton actionNickname="Disentangle" actionCode="disentangle" />
      <ActionButton actionNickname="Recombobulate" actionCode="recombobulate" />
      <ActionButton
        actionNickname="Transubstantiate"
        actionCode="transubstantiate"
      />
      <ActionButton actionNickname="Gun" actionCode="gun" />
    </div>
  );
}
