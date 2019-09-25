import axios from 'axios'
import update from 'lodash-es/update'
import { giphyApiKey } from '../config'

const ax = axios.create({
  baseURL: 'https://api.giphy.com/v1/gifs/',
  timeout: 5000
})

ax.interceptors.request.use(config => {
  return update(config, 'params', params => ({
    ...params,
    api_key: giphyApiKey
  }))
})

ax.interceptors.response.use(response => {
  if (response.status >= 200 && response.status < 400) {
    return response.data.data
  }

  return response
})

const API = {
  giphy: {
    random: config => ax.get('/random', config),
    search: (q, config) =>
      ax.get('/search', update(config, 'params', params => ({ ...params, q })))
  }
}

export default API
