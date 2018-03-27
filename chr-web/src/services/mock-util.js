
export const delayedPromise = (func, delay = 1000) => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve(func());
            //reject("Foo");
        }, delay);
    });
};
