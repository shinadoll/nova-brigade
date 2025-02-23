import { NextRequest, NextResponse } from "next/server";
import { NextApiResponse } from "next";
import path from "path";

const fs = require("node:fs");

let i: number = 0;

export async function POST(req: NextRequest, res: NextResponse) {
  try {
    var dataJson;

    await fs.readFile(
      // "/home/dreamfunicular/Code/TriangleGJ25/next-app/public/values.json",
      path.join(process.cwd(), "/public/values.json"),
      "utf8",
      (err: Error, data: string) => {
        dataJson = JSON.parse(data);

        console.log("Data JSON");
        console.log(dataJson);

        dataJson.value++;

        let contents = JSON.stringify(dataJson);

        console.log("Contents:");
        console.log(contents);

        fs.writeFile(
          path.join(process.cwd(), "/public/values.json"),
          contents,
          (err: Error, data: string) => {
            if (err) {
              return NextResponse.json({ status: 200 });
            }
          }
        );
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
