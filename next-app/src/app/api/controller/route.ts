import { NextRequest, NextResponse } from "next/server";
import { Action } from "@/types/types.ts";
import path from "path";
import fs from "node:fs";

// const fs = require("node:fs");

export async function POST(req: NextRequest, res: NextResponse) {
  try {
    var dataJson: Action;

    let reqJson: Action = await req.json();

    reqJson.userID = Math.floor(Math.random() * 100000);

    let contents = JSON.stringify(reqJson);

    console.log("Contents:");
    console.log(contents);

    fs.writeFile(
      path.join(process.cwd(), "/public/values.json"),
      contents,
      (err: Error, data: string) => {
        if (err) {
          return NextResponse.json({ status: 500 });
        }
      }
    );
  } catch {
    return NextResponse.json({
      status: 500,
    });
  } finally {
    return NextResponse.json({
      status: 500,
    });
  }
}
