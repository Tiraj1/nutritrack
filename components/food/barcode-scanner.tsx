"use client"

import { Html5QrcodeScanner } from "html5-qrcode"
import { useEffect } from "react"

export default function BarcodeScanner(){

  useEffect(()=>{

    const scanner = new Html5QrcodeScanner(
      "scanner",
      { fps: 10, qrbox: 250 },
      false
    )

    scanner.render(
      (decodedText)=>{
        alert("Barcode: "+decodedText)
      },
      ()=>{}
    )

  },[])

  return(
    <div className="mt-6">
      <h2 className="font-bold mb-2">Scan Barcode</h2>
      <div id="scanner"/>
    </div>
  )
}
