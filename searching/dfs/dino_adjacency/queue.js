export class Queue {
  constructor() {
    this.queue = []
  }

  enqueue(element) {
    this.queue.push(element)
  }

  dequeue() {
    if (this.isEmpty()) {
      throw new Error("Queue is empty.")
    }
    return this.queue.shift()
  }

  peek() {
    if (this.isEmpty()) {
      throw new Error("Queue is empty.")
    }
    return this.queue[0]
  }

  size() {
    return this.queue.length
  }

  isEmpty() {
    return this.queue.length === 0
  }
}