import { EventEmitter } from 'expo-core';
/**
 * A base class for subscribable sensors. The events emitted by this class are measurements
 * specified by the parameter type `M`.
 */
export default class DeviceSensor {
    constructor(nativeSensorModule, nativeEventName) {
        this._nativeModule = nativeSensorModule;
        this._nativeEmitter = new EventEmitter(nativeSensorModule);
        this._nativeEventName = nativeEventName;
        this._listenersCount = 0;
    }
    addListener(listener) {
        let subscription = this._nativeEmitter.addListener(this._nativeEventName, listener);
        subscription.remove = () => this.removeSubscription(subscription);
        this._listenersCount++;
        return subscription;
    }
    hasListeners() {
        return this._listenersCount > 0;
    }
    getListenerCount() {
        return this._listenersCount;
    }
    removeAllListeners() {
        this._listenersCount = 0;
        this._nativeEmitter.removeAllListeners(this._nativeEventName);
    }
    removeSubscription(subscription) {
        this._listenersCount--;
        this._nativeEmitter.removeSubscription(subscription);
    }
    setUpdateInterval(intervalMs) {
        this._nativeModule.setUpdateInterval(intervalMs);
    }
}
//# sourceMappingURL=DeviceSensor.js.map