
import {delayedPromise} from "./mock-util";

let nextPersonId = 1;



nextPersonId = 1001;

function createData() {
    const count = 2;
    const data = [];
    for (let i = 0; i < count; i++) {
        // let id = nextAssetId++;
        // data.push({id: id, type: 'Question', text: 'Question #' + id});

        let id = nextPersonId++;
        data.push({
            id: id,
            firstName: 'First' + id,
            lastName: 'Last' + id
        });
    }
    return data;
}

const DATA = createData();


class MockPeopleService {


    fetch(request) {
        // offset = 0
        // count = 10

        const offset = 0;
        const count = 10;

        return delayedPromise(() => {
            const totalCount = DATA.length;
            let returnedCount;
            if (offset + count > totalCount) {
                returnedCount = totalCount - offset - 1;
            } else {
                returnedCount = count;
            }

            const items = DATA.slice(offset, offset + returnedCount).map((item, index) => {
                //console.log(`item ${index}: ${item}`);
                item.content = undefined;
                return item;
            });

            return {
                offset: offset,
                count: returnedCount,
                totalCount: totalCount,
                items: items
            };
        }, 3000);
    }

    update(request) {
        // offset = 0
        // count = 10

        return delayedPromise(() => {

            DATA[0].content = "Muokattu: " + DATA[0].content;

            return {
                item: DATA[0]
            };
        }, 10);
    }

    fetchContent(contentId) {
        return delayedPromise(() => {
            const c = DATA.length;
            for (let i = 0; i < c; i++) {
                if (DATA[i].contentId === contentId) {
                    return DATA[i].content;
                }
            }
            return undefined;
        });
    }
}

export default MockPeopleService;
