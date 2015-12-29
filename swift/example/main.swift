
import Riffle

Riffle.SetLogLevelDebug()
Riffle.SetFabricLocal()

Riffle.ApplicationLog("Hello!")

// Setup receiver
let receiver = Receiver(name: "xs.damouse.alpha")
receiver.delegate = receiver
receiver.join()

// Setup sender
let sender = Sender(name: "xs.damouse.beta")
sender.delegate = sender
sender.join()


