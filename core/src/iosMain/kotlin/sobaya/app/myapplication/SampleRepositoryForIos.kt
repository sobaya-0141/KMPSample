package sobaya.app.myapplication

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.combine

class SampleRepositoryForIos(private val repository: SampleRepository = SampleRepository()) {
    fun combineSample(): Flow<CombineSample> {
        return combine(repository.flowSample(), repository.flowSample2()) { string, sample ->
            CombineSample(
                test = string,
                sample = sample,
            )
        }
    }
}

data class CombineSample(
    val test: String,
    val sample: Sample,
)
