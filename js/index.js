import { NativeModules } from 'react-native'

const { SsCardview } = NativeModules

console.log('SsCardview ====', SsCardview)

export default {
  ...SsCardview
}
