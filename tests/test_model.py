import tensorflow as tf

def test_model():
    model = tf.keras.models.load_model('./model_output/model.h5')
    assert model is not None, "Model should be loaded"

if __name__ == '__main__':
    test_model()
