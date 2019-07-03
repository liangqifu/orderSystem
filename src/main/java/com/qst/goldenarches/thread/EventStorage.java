package com.qst.goldenarches.thread;

import java.util.LinkedList;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.apache.logging.log4j.LogManager;

import com.qst.goldenarches.pojo.OrderPrinterLog;

public class EventStorage {
	/**
	 * 日志输出
	 */
	private static org.apache.logging.log4j.Logger logger = LogManager.getLogger(EventStorage.class);

	// 仓库最大存储量
	private final int MAX_SIZE = 100;

	// 仓库存储的载体
	private LinkedList<OrderPrinterLog> list = new LinkedList<OrderPrinterLog>();

	// 锁
	private final Lock lock = new ReentrantLock();

	// 仓库满的条件变量
	private final Condition full = lock.newCondition();

	// 仓库空的条件变量
	private final Condition empty = lock.newCondition();

	private EventStorage(){}
	
	private static class EventStorageFactory {
        private static EventStorage eventStorage = new EventStorage();
    }
	
	public static EventStorage getInstance() {
		return EventStorageFactory.eventStorage;
	}

	public int getMAX_SIZE() {
		return MAX_SIZE;
	}

	public LinkedList<OrderPrinterLog> getList() {
		return list;
	}

	public void putEvent(OrderPrinterLog event) throws InterruptedException {
		// 获得锁
		lock.lock();

		// 如果执行等级为低级
		if (list.size() > MAX_SIZE) {
			// 唤醒其他所有线程
			full.signalAll();
			empty.signalAll();
			// 释放锁
			lock.unlock();
			return;
		}

		// 如果仓库剩余容量不足
		while (list.size() > MAX_SIZE) {
			// 由于条件不满足，生产阻塞
			full.await();
		}

		list.add(event);
		// 唤醒其他所有线程
		full.signalAll();
		empty.signalAll();
		// 释放锁
		lock.unlock();
	}

	public OrderPrinterLog takeEvent() throws InterruptedException {
		// 获得锁
		lock.lock();

		// 如果仓库存储量不足
		while (list.isEmpty()) {
			// 由于条件不满足，消费阻塞
			empty.await();

		}

		OrderPrinterLog event = list.getFirst();
		list.removeFirst();
		// 唤醒其他所有线程
		full.signalAll();
		empty.signalAll();
		// 释放锁
		lock.unlock();
		return event;
	}
}
