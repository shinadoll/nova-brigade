import { Action } from "@/types/types.ts";

export default function ActionButton({ action }: { action: Action }) {
  async function Click() {
    const res = await fetch("/api/controller", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(action),
    });

    console.log(action.shortName);

    if (res == null) {
      console.log("Gibt shit!");
    } else {
      console.log(res);
    }
  }

  return (
    <button
      className="h-24 w-80 bg-pink-400 rounded-2xl m-4 border-solid border-4 border-gray-400 hover:border-gray-300 items-center flex justify-center"
      onClick={Click}>
      {" "}
      <p className="text-2xl font-bold italic"> {action.displayName} </p>
    </button>
  );
}
