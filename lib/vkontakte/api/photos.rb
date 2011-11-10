module Vkontakte
  module Api
    module Photos
    
      def self.included(base)
        base.class_eval do
          define_method :photos do
            @photos ||= Photos.new(base)
          end
        end
      end
      
      class Photos < Vkontakte::Api::Base
      
        # возвращает список альбомов пользователя.
        #
        def getAlbums(options={})
          call('photos.getAlbums', options)
        end
        
        # возвращает количество альбомов пользователя.
        #
        def getAlbumsCount(options={})
          call('photos.getAlbumsCount', options)
        end
        
        # возвращает список фотографий в альбоме.
        #
        def get(options={})
          call('photos.get', options)
        end
        
        # возвращает все фотографии пользователя в антихронологическом порядке.
        #
        def getAll(options={})
          call('photos.getAll', options)
        end
        
        # возвращает информацию о фотографиях.
        #
        def getById(options={})
          call('photos.getById', options)
        end
        
        # создает пустой альбом для фотографий.
        #
        def createAlbum(options={})
          call('photos.createAlbum', options)
        end
        
        # обновляет данные альбома для фотографий.
        #
        def editAlbum(options={})
          call('photos.editAlbum', options)
        end
        
        # переносит фотографию из одного альбома в другой.
        #
        def move(options={})
          call('photos.move', options)
        end
        
        # делает фотографию обложкой альбома.
        #
        def makeCover(options={})
          call('photos.makeCover', options)
        end
        
        # меняет порядок альбома в списке альбомов пользователя.
        #
        def reorderAlbums(options={})
          call('photos.reorderAlbums', options)
        end
        
        # меняет порядок фотографий в списке фотографий альбома.
        #
        def reorderPhotos(options={})
          call('photos.reorderPhotos', options)
        end
        
        # возвращает адрес сервера для загрузки фотографий.
        #
        def getUploadServer(options={})
          call('photos.getUploadServer', options)
        end
        
        # сохраняет фотографии после успешной загрузки.
        #
        def save(options={})
          call('photos.save', options)
        end
        
        # возвращает адрес сервера для загрузки фотографии на страницу пользователя.
        #
        def getProfileUploadServer(options={})
          call('photos.getProfileUploadServer', options)
        end
        
        # сохраняет фотографию страницы пользователя после успешной загрузки.
        #
        def saveProfilePhoto(options={})
          call('photos.saveProfilePhoto', options)
        end
        
        # возвращает адрес сервера для загрузки фотографии в специальный альбом, предназначенный для фотографий со стены.
        #
        def getWallUploadServer(options={})
          call('photos.getWallUploadServer', options)
        end
        
        # сохраняет фотографию после успешной загрузки.
        #
        def saveWallPhoto(options={})
          call('photos.saveWallPhoto', options)
        end
      end
    end
  end
end
