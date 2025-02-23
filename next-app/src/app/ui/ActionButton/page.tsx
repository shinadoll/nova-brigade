export default function ActionButton(props: {
  actionNickname: string;
  actionCode: string;
}) {
  async function Click() {
    console.log(props.actionNickname);

    const res = await fetch("/api/controller", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        ActionCode: props.actionCode,
      },
      body: JSON.stringify({ actionCode: props.actionCode }),
    });

    console.log(props.actionCode);

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
      <p className="text-2xl font-bold italic"> {props.actionNickname} </p>
    </button>
  );
}
