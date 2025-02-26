package com.cool.element.nav_poc_1

interface AppViewModel {

}

interface DemoRecordsListViewModel: AppViewModel {
    fun recordsAsList(): List<DemoRecord>
}

class StubDemoRecordsListViewModel: DemoRecordsListViewModel {
    override fun recordsAsList(): List<DemoRecord> {
        return DemoRecord.sampleList
    }
}