"use client";

export default function Page() {
  async function Click() {
    console.log("Hello, world!");

    const res = await fetch("/api/controller", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
    });

    if (res == null) {
      console.log("Gibt shit!");
    } else {
      console.log(res);
    }
  }

  return (
    <button
      className="h-40 w-40 bg-pink-300 rounded-2xl m-4 border-solid border-4 border-gray-400 hover:border-gray-300 items-center flex justify-center"
      onClick={Click}>
      {" "}
      <p> Increment </p>
    </button>
  );
}
