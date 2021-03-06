# -*- coding: utf-8 -*-
"""File1.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1g3qDFfFY2s7gr4hbl-Mz6jxjos7DoM0_

# **Tourism Recommendation System**
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
import warnings
import tensorflow as tf

from keras.layers import Input, Embedding, Flatten, Dot, Dense, Concatenate
from keras.models import Model

"""## Upload and Loading Data"""

# Code to read csv file into Colaboratory:
!pip install -U -q PyDrive
!pip install google-colab
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
from google.colab import auth
from oauth2client.client import GoogleCredentials

# Authenticate and create the PyDrive client.
auth.authenticate_user()
gauth = GoogleAuth()
gauth.credentials = GoogleCredentials.get_application_default()
drive = GoogleDrive(gauth)

#link = 'https://drive.google.com/file/d/1aAMG28cyow5leAO8ZJtj8TYm7seLQcU7/view?usp=sharing'

downloaded = drive.CreateFile({'id':'1aAMG28cyow5leAO8ZJtj8TYm7seLQcU7'}) 
downloaded.GetContentFile('tourism_filtering.csv')

dataset = pd.read_csv('tourism_filtering.csv')

dataset.head()

dataset.shape

"""## Split Data"""

from sklearn.model_selection import train_test_split
train, test = train_test_split(dataset, test_size=0.2, random_state=42)

train.head()

test.head()

n_tourists = len(dataset.Tourist_Id.unique())
n_tourists

n_places = len(dataset.Place_Id.unique())
n_places

"""## Creating Dot Product Model"""

# creating place embedding path
place_input = Input(shape=[1], name="Place-Input")
place_embedding = Embedding(n_places+1, 5, name="Place-Embedding")(place_input)
place_vec = Flatten(name="Flatten-Places")(place_embedding)

# creating tourist embedding path
tourist_input = Input(shape=[1], name="Tourist-Input")
tourist_embedding = Embedding(n_tourists+1, 5, name="User-Embedding")(tourist_input)
tourist_vec = Flatten(name="Flatten-Tourists")(tourist_embedding)

# performing dot product and creating model
prod = Dot(name="Dot-Product", axes=1)([place_vec, tourist_vec])
model = Model([tourist_input, place_input], prod)
model.compile('adam', 'mean_squared_error')

history = model.fit([train.Tourist_Id, train.Place_Id], train.Rating, epochs=30, verbose=1)
model.save('recommendation_model.h5')
plt.plot(history.history['loss'])
plt.xlabel("Epochs")
plt.ylabel("Training Error")

model.evaluate([test.Tourist_Id, test.Place_Id], test.Rating)

"""## Creating Neural Network Model"""

# creating place embedding path
place_input = Input(shape=[1], name="Place-Input")
place_embedding = Embedding(n_places+1, 5, name="Place-Embedding")(place_input)
place_vec = Flatten(name="Flatten-Places")(place_embedding)

# creating user embedding path
tourist_input = Input(shape=[1], name="Tourist-Input")
tourist_embedding = Embedding(n_tourists+1, 5, name="Tourist-Embedding")(tourist_input)
tourist_vec = Flatten(name="Flatten-Tourist")(tourist_embedding)

# concatenate features
conc = Concatenate()([place_vec, tourist_vec])

# add fully-connected-layers
fc1 = Dense(128, activation='relu')(conc)
fc2 = Dense(32, activation='relu')(fc1)
out = Dense(1)(fc2)

# Create model and compile it
model2 = Model([tourist_input, place_input], out)
model2.compile('adam', 'mean_squared_error')

model.summary()

history = model2.fit([train.Tourist_Id, train.Place_Id], train.Rating, epochs=30, verbose=1)
model2.save('recommendation_model2.h5')
plt.plot(history.history['loss'])
plt.xlabel("Epochs")
plt.ylabel("Training Error")

model2.evaluate([test.Tourist_Id, test.Place_Id], test.Rating)

"""## Predict Recommendation"""

# Creating dataset for predict recommendations
place_data = np.array(list(set(dataset.Place_Id)))
place_data[:132]

tourist_id = 276

tourist = np.array([tourist_id for i in range(len(place_data))])
tourist[:5]

predictions = model.predict([tourist, place_data])

predictions = np.array([a[0] for a in predictions])

recommended_place_ids = (-predictions).argsort()[:5]

recommended_place_ids

predictions[recommended_place_ids]

#link = 'https://drive.google.com/file/d/1s9B06Y9txoLqLq0PSHRnXQHuRDW4C6aN/view?usp=sharing'

downloaded = drive.CreateFile({'id':'1s9B06Y9txoLqLq0PSHRnXQHuRDW4C6aN'}) 
downloaded.GetContentFile('tourism_description.csv')

tourism_spot = pd.read_csv('tourism_description.csv')

tourism_spot.head()

tourism_spot[tourism_spot['Place_Id'].isin(recommended_place_ids)]